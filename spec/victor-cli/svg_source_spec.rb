require "spec_helper"

describe SVGSource do
  subject { described_class.new svg_tree }
  let(:svg_tree) do
    XmlNode.new(
      "svg",
      { "a" => "b" },
      [XmlNode.new("rect", { "x" => "10" }, [])]
    )
  end

  describe "#initialize" do
    context "with a string input" do
      let(:svg_tree) { '<svg><g><rect x="10" /></g></svg>' }

      it "parses the string to obtain the svg tree" do
        expect(subject.ruby_code).to match_fixture('svg_source/string-input.rb')
      end
    end
  end

  describe "#ruby_code" do
    it "converts the svg tree into ruby code" do
      expect(subject.ruby_code).to match_fixture('svg_source/basic.rb')
    end

    context "with nested nodes" do
      let(:svg_tree) do
        XmlNode.new(
          "g", { "a" => "b" }, [XmlNode.new("rect", { "x" => "10" }, [])]
        )
      end

      it "converts the svg tree into ruby code" do
        expect(subject.ruby_code).to match_fixture('svg_source/nested-nodes.rb')
      end
    end

    context "with text nodes and css", :focus do
      let(:svg_tree) { File.read 'spec/fixtures/text-nodes-and-css.svg' }

      it "converts the svg tree into ruby code" do
        expect(subject.ruby_code).to match_fixture('svg_source/text-nodes-and-css.rb')
      end
    end

    context "with dsl template" do
      subject { described_class.new svg_tree, template: :dsl }

      it "uses the dsl ruby template" do
        expect(subject.ruby_code).to match_fixture('svg_source/dsl-template.rb')
      end
    end

    context "with standalone template" do
      subject { described_class.new svg_tree, template: :standalone }

      it "uses the dsl ruby template" do
        expect(subject.ruby_code).to match_fixture('svg_source/standalone-template.rb')
      end
    end

    context "with an invalid template" do
      subject { described_class.new svg_tree, template: :no_such_template }

      it "raises an error" do
        expect { subject.ruby_code }.to raise_fixture('svg_source/invalid-template')
      end      
    end
  end
end
