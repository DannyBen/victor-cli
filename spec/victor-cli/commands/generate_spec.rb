require "spec_helper"

describe "victor generate" do
  subject { CommandLine.router }
  let(:svg_file) { 'spec/fixtures/pacman.svg' }

  context "without arguments" do
    it "shows short usage" do
      expect { subject.run %w[generate] }.to output_fixture("cli/generate/usage")
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect { subject.run %w[generate --help] }.to output_fixture("cli/generate/help")
    end
  end

  context "with SVG_FILE" do
    it "outputs the converted ruby code to stdout" do
      expect { subject.run ["generate", svg_file] }.to output_fixture('cli/generate/ruby-code.rb')
    end
  end

  context "with SVG_FILE RUBY_FILE" do
    let(:ruby_file) { 'spec/tmp/code.rb' }
    before { system "rm #{ruby_file}" if File.exist? ruby_file }

    it "saves the converted ruby code" do
      expect { subject.run ["generate", svg_file, ruby_file] }.to output_fixture('cli/generate/save')
      expect(File.read ruby_file).to match_fixture('cli/generate/ruby-code.rb')
    end
  end
end
