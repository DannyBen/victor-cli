require "spec_helper"

describe CodeGenerator do
  subject { described_class.new svg_tree }

  describe "#generate" do
    let(:svg_tree) {
      ["svg", { "a" => "b" }, [["rect", { "x" => "10" }, []]]]
    }

    it "converts the svg tree into ruby code" do
      expect(subject.generate).to match_fixture('code_generator/basic.rb')
    end

    context "with nested nodes" do
      let(:svg_tree) {
        ["g", { "a" => "b" }, [["rect", { "x" => "10" }, []]]]
      }

      it "converts the svg tree into ruby code" do
        expect(subject.generate).to match_fixture('code_generator/nested-nodes.rb')
      end
    end
  end
end
