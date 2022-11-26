require 'spec_helper'

describe 'victor convert' do
  subject { CommandLine.router }

  let(:svg_file) { 'spec/fixtures/convert/pacman.svg' }

  context 'without arguments' do
    it 'shows short usage' do
      expect { subject.run %w[convert] }.to output_approval('cli/convert/usage')
    end
  end

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.run %w[convert --help] }.to output_approval('cli/convert/help')
    end
  end

  context 'with SVG_FILE' do
    it 'outputs the converted ruby code to stdout' do
      expect { subject.run ['convert', svg_file] }.to output_approval('cli/convert/ruby-code.rb')
    end
  end

  context 'with SVG_FILE RUBY_FILE' do
    let(:ruby_file) { 'spec/tmp/code.rb' }

    before { File.unlink ruby_file if File.exist? ruby_file }

    it 'saves the converted ruby code' do
      expect { subject.run ['convert', svg_file, ruby_file] }.to output_approval('cli/convert/save')
      expect(File.read ruby_file).to match_approval('cli/convert/ruby-code.rb')
    end
  end

  context 'with SVG_FILE --template NAME' do
    it 'uses the specified template name' do
      expect { subject.run %W[convert #{svg_file} --template dsl] }
        .to output_approval('cli/convert/template-dsl')
    end

    context 'when the template NAME is invalid' do
      it 'raises a friendly error' do
        expect { subject.run %W[convert #{svg_file} --template invalid] }
          .to raise_approval('cli/convert/invalid-template')
      end
    end
  end
end
