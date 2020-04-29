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
        # cannot use fixture here, since output varies between rubies
        expect(`bin/victor to-svg #{script} 2>&1`)
          .to match(/SyntaxError.*unterminated string meets end of file/m)
      end
    end

    context "when there is any other error in the user script" do
      let(:script) { "spec/fixtures/other-error.rb" }

      it "errors gracefuly with backtrace info" do
        # cannot use fixture here, since output varies between rubies
        expect(`bin/victor to-svg #{script} 2>&1`)
          .to match(/NameError.*undefined local variable or method .error./m)
      end
    end
  end
end
