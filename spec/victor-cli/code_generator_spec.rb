require "spec_helper"

describe CodeGenerator do
  subject { described_class.new svg_tree }
  let(:svg_tree) do
    ["svg", { "a" => "b" }, [["rect", { "x" => "10" }, []]]]
  end

  describe "#generate" do
    it "converts the svg tree into ruby code" do
      expect(subject.generate).to match_fixture('code_generator/basic.rb')
    end

    context "with nested nodes" do
      let(:svg_tree) do
        ["g", { "a" => "b" }, [["rect", { "x" => "10" }, []]]]
      end

      it "converts the svg tree into ruby code" do
        expect(subject.generate).to match_fixture('code_generator/nested-nodes.rb')
      end
    end

    context "with dsl template" do
      subject { described_class.new svg_tree, template: :dsl }

      it "uses the dsl ruby template" do
        expect(subject.generate).to match_fixture('code_generator/dsl-template.rb')
      end
    end

    context "with standalone template" do
      subject { described_class.new svg_tree, template: :standalone }

      it "uses the dsl ruby template" do
        expect(subject.generate).to match_fixture('code_generator/standalone-template.rb')
      end
    end

    context "with an invalid template" do
      subject { described_class.new svg_tree, template: :no_such_template }

      it "raises an error" do
        expect { subject.generate }.to raise_fixture('code_generator/invalid-template')
      end      
    end
  end
end
