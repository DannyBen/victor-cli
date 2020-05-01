require "spec_helper"

describe RubySource do
  subject { described_class.new code }
  let(:code) { "puts 'hello'" }

  it "has a Victor::SVG instance" do
    expect(subject.svg).to be_a Victor::SVG
  end

  it "includes Victor::DSL methods" do
    expect(subject).to respond_to :setup
  end

  describe "#evaluate" do
    it "evaluates the ruby code" do
      expect { subject.evaluate }.to output("hello\n").to_stdout
    end
  end

  describe "#template" do
    it "sets the template on the svg instance" do
      expect(subject.svg).to receive(:template=).with(:minimal)
      subject.template 'minimal'
    end

    context "when the template is a filename" do
      let(:template_file) { "spec/fixtures/template.svg" }

      it "sets the template on the svg instance" do
        expect(subject.svg).to receive(:template=).with(template_file)
        subject.template template_file
      end

      context "when the file is not found" do
        let(:template_file) { "no-such-template.svg" }

        it "raises a friendly error" do
          expect { subject.template template_file }.to raise_fixture('ruby_source/invalid-template')
        end        
      end
    end
  end
end
