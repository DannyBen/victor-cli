describe 'bin/victor' do
  subject { CommandLine.router }

  it 'shows list of commands' do
    expect { subject.run }.to output_approval('cli/commands')
  end

  context 'when an exception occurs' do
    it 'errors gracefully' do
      expect(`bin/victor convert no-such-file 2>&1`).to match_approval('cli/exception')
    end
  end

  describe 'render' do
    context 'when there is a syntax error in the user script' do
      let(:script) { 'spec/fixtures/bin/syntax-error.rb' }

      it 'errors gracefully with backtrace info' do
        # cannot use fixture here, since output varies between rubies
        expect(`bin/victor render #{script} 2>&1`)
          .to match(/SyntaxError.*unterminated string meets end of file/m)
      end
    end

    context 'when there is any other error in the user script' do
      let(:script) { 'spec/fixtures/bin/other-error.rb' }

      it 'errors gracefully with backtrace info' do
        # cannot use fixture here, since output varies between rubies
        expect(`bin/victor render #{script} 2>&1`)
          .to match(/NameError.*undefined local variable or method .error./m)
      end
    end
  end
end
