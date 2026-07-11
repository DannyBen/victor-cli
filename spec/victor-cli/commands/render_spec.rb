describe Commands::Render do
  let(:ruby_file) { 'spec/fixtures/render/pacman_dsl.rb' }
  let(:listener) { double(:listener, start: nil) }

  context 'without arguments' do
    it 'shows short usage' do
      expect { subject.execute %w[render] }.to output_approval('cli/render/usage')
    end
  end

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[render --help] }.to output_approval('cli/render/help')
    end
  end

  context 'with RUBY_FILE' do
    it 'outputs the converted SVG code to stdout' do
      expect { subject.execute %W[render #{ruby_file}] }
        .to output_approval('cli/render/svg-code.svg')
    end
  end

  context 'with RUBY_FILE PARAMS...' do
    it 'passes param pairs to the DSL' do
      expect { subject.execute %W[render #{ruby_file} color=blue] }
        .to output_approval('cli/render/svg-code-blue.svg')
    end
  end

  context 'with RUBY_FILE --watch' do
    before { allow(subject).to receive(:sleep) }

    it 'generates immediately and watches for changes' do
      allow(Listen).to receive(:to).and_return(listener)
      expect(listener).to receive(:start)

      expect { subject.execute %W[render #{ruby_file} --watch] }
        .to output_approval('cli/render/watch')
    end

    it 'yields only when changes are present' do
      expect(subject).to receive(:listener)
        .and_yield([], [], [])
        .and_yield(['changed'], [], [])
        .and_return(listener)
      expect(listener).to receive(:start)

      count = 0
      subject.send(:watch) { count += 1 }
      expect(count).to eq 1
    end

    context 'when the script contains an error' do
      it 'shows it gracefully and continues to watch' do
        call_count = 0
        allow(subject).to receive(:generate) do
          call_count += 1
          raise 'Intentional error' if call_count == 2
        end
        expect(subject).to receive(:watch).and_yield

        expect { subject.execute %W[render #{ruby_file} --watch] }
          .to output_approval('cli/render/watch-error').to_stderr
      end
    end

    context 'when interrupted' do
      it 'shows a friendly message' do
        allow(subject).to receive(:safe_generate)
        allow(subject).to receive(:watch).and_raise(Interrupt)

        expect { subject.execute %W[render #{ruby_file} --watch] }
          .to output_approval('cli/render/watch-interrupt')
      end
    end
  end

  context 'with RUBY_FILE --save SVG_FILE' do
    let(:svg_file) { 'spec/tmp/svg.svg' }

    before { File.unlink svg_file if File.exist? svg_file }

    it 'saves the converted SVG code' do
      expect { subject.execute %W[render #{ruby_file} --save #{svg_file}] }
        .to output_approval('cli/render/save')

      expect(File.read(svg_file)).to match_approval('cli/render/svg-code.svg')
    end
  end

  context 'with RUBY_FILE --template TEMPLATE' do
    context 'when TEMPLATE is a built in name' do
      it 'uses the correct template' do
        expect { subject.execute %W[render #{ruby_file} -t minimal] }
          .to output_approval('cli/render/minimal-template.svg')
      end
    end

    context 'when TEMPLATE is a path to file' do
      let(:template_file) { 'spec/fixtures/render/template.svg' }

      it 'uses the correct template' do
        expect { subject.execute %W[render #{ruby_file} -t #{template_file}] }
          .to output_approval('cli/render/custom-template.svg')
      end
    end
  end
end
