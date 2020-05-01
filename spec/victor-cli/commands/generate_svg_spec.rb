require "spec_helper"

describe "victor to-svg" do
  subject { CommandLine.router }
  let(:ruby_file) { 'spec/fixtures/pacman-dsl.rb' }

  context "without arguments" do
    it "shows short usage" do
      expect { subject.run %w[to-svg] }.to output_fixture("cli/to-svg/usage")
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect { subject.run %w[to-svg --help] }.to output_fixture("cli/to-svg/help")
    end
  end

  context "with RUBY_FILE" do
    it "outputs the converted SVG code to stdout" do
      expect { subject.run ["to-svg", ruby_file] }.to output_fixture('cli/to-svg/svg-code.svg')
    end
  end

  context "with RUBY_FILE --watch" do
    it "generates immediately and on change" do
      expect do
        expect_any_instance_of(Filewatcher).to receive(:watch) do |watcher, &block|
          block.call
        end

        subject.run %W[to-svg #{ruby_file} --watch]
      end.to output_fixture('cli/to-svg/watch')
    end
  end

  context "with RUBY_FILE SVG_FILE" do
    let(:svg_file) { 'spec/tmp/svg.svg' }
    before { File.unlink svg_file if File.exist? svg_file }

    it "saves the converted SVG code" do
      expect { subject.run ["to-svg", ruby_file, svg_file] }.to output_fixture('cli/to-svg/save')
      expect(File.read(svg_file) + "\n").to match_fixture('cli/to-svg/svg-code.svg')
    end
  end

  context "with RUBY_FILE --template TEMPLATE" do
    context "when TEMPLATE is a built in name" do
      it "uses the correct template" do
        expect { subject.run %W[to-svg #{ruby_file} -t minimal] }.to output_fixture('cli/to-svg/minimal-template.svg')
      end
    end

    context "when TEMPLATE is a path to file" do
      let(:template_file) { 'spec/fixtures/template.svg' }

      it "uses the correct template" do
        expect { subject.run %W[to-svg #{ruby_file} -t #{template_file}] }.to output_fixture('cli/to-svg/custom-template.svg')
      end
    end
  end
end
