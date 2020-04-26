require 'spec_helper'

describe 'bin/victor-cli-generate' do
  subject { CLI.router }

  context "without arguments" do
    it "shows short usage" do
      expect{ subject.run %w[generate]}.to output_fixture('cli/generate/usage')
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[generate --help] }.to output_fixture('cli/generate/help')
    end
  end

  context "with required arguments" do
    # Implement
  end
end
