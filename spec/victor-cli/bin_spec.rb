require 'spec_helper'

describe 'bin/victor' do
  subject { CommandLine.router }

  it "shows list of commands" do
    expect{ subject.run }.to output_fixture('cli/commands')
  end

  context "on exception" do
    it "errors gracefuly" do
      expect(`bin/victor to-ruby no-such-file 2>&1`).to match_fixture('cli/exception')
    end
  end

  describe 'to-svg' do
    context "when there is a syntax error in the user script" do
      let(:script) { "spec/fixtures/syntax-error.rb" }

      it "errors gracefuly with backtrace info" do
        expect(`bin/victor to-svg #{script} 2>&1`)
          .to match_fixture('cli/syntax-error-script')
      end
    end

    context "when there is any other error in the user script" do
      let(:script) { "spec/fixtures/other-error.rb" }

      it "errors gracefuly with backtrace info" do
        expect(`bin/victor to-svg #{script} 2>&1`)
          .to match_fixture('cli/other-error-script')
          .except(/RubyCode:.*>/, 'RubyCode:...>')
      end
    end
  end
end
