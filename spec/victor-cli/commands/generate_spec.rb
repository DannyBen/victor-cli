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
      expect { subject.run ["generate", svg_file] }.to output_fixture('cli/generate/ruby-code')
    end
  end

  context "with SVG_FILE RUBY_FILE" do
    it "saves the converted ruby code" do
      Tempfile.create "ruby-code" do |file|
        subject.run ["generate", svg_file, file.path]
        expect(File.read file.path).to match_fixture('cli/generate/ruby-code')
      end
    end
  end
end
