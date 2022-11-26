require 'spec_helper'

describe Commands::Render do
  let(:ruby_file) { 'spec/fixtures/render/pacman_dsl.rb' }
  let(:filewatcher) { Filewatcher.new 'path' }

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
      expect { subject.execute ['render', ruby_file] }.to output_approval('cli/render/svg-code.svg')
    end
  end

  context 'with RUBY_FILE --watch' do
    it 'generates immediately and on change' do
      allow(Filewatcher).to receive(:new).and_return(filewatcher)
      expect(filewatcher).to receive(:watch) do |_watcher, &block|
        changes = { 'some-path' => :updated }
        block.call changes
      end

      expect { subject.execute %W[render #{ruby_file} --watch] }
        .to output_approval('cli/render/watch')
    end

    context 'when the script contains an error' do
      it 'shows it gracefully and continues to watch' do
        expect(subject).to receive(:watch) do |_watcher, &block|
          allow(subject).to receive(:generate).and_raise('Intentional error')
          changes = { 'some-path' => :updated }
          block.call changes
        end

        expect { subject.execute %W[render #{ruby_file} --watch] }
          .to output_approval('cli/render/watch-error').to_stderr
      end
    end
  end

  context 'with RUBY_FILE SVG_FILE' do
    let(:svg_file) { 'spec/tmp/svg.svg' }

    before { File.unlink svg_file if File.exist? svg_file }

    it 'saves the converted SVG code' do
      expect { subject.execute ['render', ruby_file, svg_file] }.to output_approval('cli/render/save')
      expect("#{File.read(svg_file)}\n").to match_approval('cli/render/svg-code.svg')
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
