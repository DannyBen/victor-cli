describe PairSplit do
  using described_class

  subject { ["color=blue", "text=Hello World"] }

  describe Array do
    describe '#pair_split' do
      it 'splits key=value pairs and returns a hash' do
        expect(subject.pair_split).to eq({ color: 'blue', text: 'Hello World' })
      end
    end
  end
end
