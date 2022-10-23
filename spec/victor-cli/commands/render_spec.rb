require "spec_helper"

describe "victor render" do
  subject { CommandLine.router }
  let(:ruby_file) { 'spec/fixtures/render/pacman-dsl.rb' }

  context "without arguments" do
    it "shows short usage" do
      expect { subject.run %w[render] }.to output_approval("cli/render/usage")
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect { subject.run %w[render --help] }.to output_approval("cli/render/help")
    end
  end

  context "with RUBY_FILE" do
    it "outputs the converted SVG code to stdout" do
      expect { subject.run ["render", ruby_file] }.to output_approval('cli/render/svg-code.svg')
    end
  end

  context "with RUBY_FILE --watch" do
    it "generates immediately and on change" do
      expect do
        expect_any_instance_of(Filewatcher).to receive(:watch) do |watcher, &block|
          changes = { "some-path" => :updated }
          block.call changes
        end

        subject.run %W[render #{ruby_file} --watch]
      end.to output_approval('cli/render/watch')
    end

    context "when the script contains an error" do
      it "shows it gracefully and continues to watch" do
        command = Victor::CLI::Commands::Render
        expect do
          expect_any_instance_of(command).to receive(:watch) do |watcher, &block|
            expect_any_instance_of(command).to receive(:generate) do
              raise Exception, "Intentional error"
            end
            changes = { "some-path" => :updated }
            block.call changes
          end
          subject.run %W[render #{ruby_file} --watch]
        end.to output_approval('cli/render/watch-error').to_stderr
      end
    end
  end

  context "with RUBY_FILE SVG_FILE" do
    let(:svg_file) { 'spec/tmp/svg.svg' }
    before { File.unlink svg_file if File.exist? svg_file }

    it "saves the converted SVG code" do
      expect { subject.run ["render", ruby_file, svg_file] }.to output_approval('cli/render/save')
      expect(File.read(svg_file) + "\n").to match_approval('cli/render/svg-code.svg')
    end
  end

  context "with RUBY_FILE --template TEMPLATE" do
    context "when TEMPLATE is a built in name" do
      it "uses the correct template" do
        expect { subject.run %W[render #{ruby_file} -t minimal] }.to output_approval('cli/render/minimal-template.svg')
      end
    end

    context "when TEMPLATE is a path to file" do
      let(:template_file) { 'spec/fixtures/render/template.svg' }

      it "uses the correct template" do
        expect { subject.run %W[render #{ruby_file} -t #{template_file}] }.to output_approval('cli/render/custom-template.svg')
      end
    end
  end
end
