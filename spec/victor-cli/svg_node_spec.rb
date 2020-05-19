require "spec_helper"

describe SVGNode do
  subject { described_class.load_file "spec/fixtures/svg_node/#{file}.svg" }
  let(:file) { "basic" }

  describe '#inspect' do
    it "returns a compact representation" do
      expect(subject.inspect).to eq "#<Victor::CLI::SVGNode name=svg, type=root>"
    end
  end

  describe '#render' do
    context "with basic SVG" do
      it "works" do
        expect(subject.render).to match_approval('svg_node/basic.rb')
      end
    end

    context "with namespaced attributes" do
      let(:file) { "namespaced-attributes" }
      
      it "works" do
        expect(subject.render).to match_approval('svg_node/namespaced-attributes.rb')
      end
    end

    context "with advanced SVG" do
      let(:file) { "advanced" }
      
      it "works" do
        expect(subject.render).to match_approval('svg_node/advanced.rb')
      end
    end

    context "with broken SVG" do
      let(:file) { "broken" }
      
      it "raises an errpr" do
        expect { subject.render }.to raise_approval('svg_node/broken')
      end
    end
  end
end
