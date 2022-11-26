require 'spec_helper'

describe 'victor init' do
  subject { CommandLine.router }

  context 'without arguments' do
    it 'shows short usage' do
      expect { subject.run %w[init] }
        .to output_approval('cli/init/usage')
    end
  end

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.run %w[init --help] }
        .to output_approval('cli/init/help')
    end
  end

  context 'with RUBY_FILE' do
    let(:ruby_file) { 'spec/tmp/ghost.rb' }

    before { File.unlink ruby_file if File.exist? ruby_file }

    it 'saves a sample' do
      expect { subject.run %W[init #{ruby_file}] }
        .to output_approval('cli/init/save')

      expect(File.read ruby_file)
        .to match_approval('cli/init/generated-default.rb')
    end

    context 'when the file does not have .rb extension' do
      let(:ruby_file) { 'spec/tmp/ghost' }

      before { File.unlink "#{ruby_file}.rb" if File.exist? "#{ruby_file}.rb" }

      it 'adds it' do
        expect { subject.run %W[init #{ruby_file}] }
          .to output_approval('cli/init/save')
      end
    end

    context 'when the file exists' do
      before { File.write ruby_file, 'dummy' }

      it 'aborts gracefully' do
        # Different Ruby versions show exception slightly differently
        # Hence the diff
        expect { subject.run %W[init #{ruby_file}] }
          .to raise_approval('cli/init/file-exist')
          .diff(4)
      end
    end

    context 'with --template NAME' do
      it 'saves using the requested template' do
        expect { subject.run %W[init #{ruby_file} --template standalone] }
          .to output_approval('cli/init/save-standalone')

        expect(File.read ruby_file)
          .to match_approval('cli/init/generated-standalone.rb')
      end

      context 'when the template is invalid' do
        it 'raises an error' do
          # Different Ruby versions show exception slightly differently
          # Hence the diff
          expect { subject.run %W[init #{ruby_file} --template not-found] }
            .to raise_approval('cli/init/invalid-template')
            .diff(4)
        end
      end
    end
  end
end
