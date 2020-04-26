require 'spec_helper'

describe 'bin/victor' do
  subject { CommandLine.router }

  it "shows list of commands" do
    expect{ subject.run }.to output_fixture('cli/commands')
  end

  context "on exception" do
    it "errors gracefuly" do
      expect(`bin/victor command that errors 2>&1`).to match_fixture('cli/exception')
    end
  end
end
