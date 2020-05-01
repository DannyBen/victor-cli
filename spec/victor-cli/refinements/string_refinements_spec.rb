require "spec_helper"

describe String do
  using Refinements

  describe "#format_as_key" do
    it "converts hyphens to underscores" do
      expect("font-size".format_as_key).to eq "font_size"
    end
  end

  describe '#format_as_value' do
    it "adds quotes to non numeric values" do
      expect("#123456".format_as_value).to eq %q["#123456"]
    end

    it "does not add quotes to integer values" do
      expect("123".format_as_value).to eq "123"
    end

    it "does not add quotes to float values" do
      expect("12.3".format_as_value).to eq "12.3"
    end
  end
end
