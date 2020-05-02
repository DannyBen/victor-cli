require "spec_helper"

describe Parser do
  subject { described_class.new svg }
  let(:svg) { File.read "spec/fixtures/#{filename}.svg" }

  describe "#parse" do
    let(:filename) { 'basic' }

    it "converts the svg into a simple tree structure" do
      expect(subject.parse.to_yaml).to match_fixture('parser/basic')
    end

    context "with namespaced attributes" do
      let(:filename) { 'namespaced-args' }

      it "parses the attributes correctly" do
        expect(subject.parse.to_yaml).to match_fixture('parser/namespaced-args')
      end
    end

    context "with text node" do
      let(:filename) { 'text-node' }

      it "parses the attributes correctly" do
        expect(subject.parse.to_yaml).to match_fixture('parser/text-node')
      end
    end

    context "with style node" do
      let(:filename) { 'style-node' }

      it "parses the attributes correctly" do
        expect(subject.parse.to_yaml).to match_fixture('parser/style-node')
      end
    end
  end
end
