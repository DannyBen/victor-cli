require "spec_helper"

describe "victor generate" do
  subject { CommandLine.router }

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

  context "with required arguments" do
    let(:fixture_root) { File.join(__dir__, "..", "..", "fixtures") }
    let(:svg_path) { File.join(fixture_root, "pacman.svg") }
    let(:converted_path) { File.join(fixture_root, "pacman.rb") }
    let(:converted_code) { File.read(converted_path) }

    it "outputs the converted code to stdout if no ruby file is specified" do
      expect {
        subject.run ["generate", svg_path]
      }.to output(converted_code).to_stdout
    end

    it "outputs the converted code to specified file" do
      Tempfile.create("ruby-code") do |file|
        subject.run ["generate", svg_path, file.path]
        expect(File.read(file.path)).to eql(converted_code)
      end
    end
  end
end
