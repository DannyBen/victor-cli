describe Rendering do
  using described_class

  describe String do
    describe '#to_key' do
      it 'converts hyphens to underscores' do
        expect('font-size'.to_key).to eq 'font_size'
      end
    end

    describe '#to_value' do
      it 'adds quotes to non numeric values' do
        expect('#123456'.to_value).to eq '"#123456"'
      end

      it 'does not add quotes to integer values' do
        expect('123'.to_value).to eq '123'
      end

      it 'does not add quotes to float values' do
        expect('12.3'.to_value).to eq '12.3'
      end
    end

    describe '#style_to_hash' do
      subject { 'font-weight: bold; top: 10px; left: 20' }

      it 'converts a style string to a hash' do
        expect(subject.style_to_hash)
          .to eq({ 'font-weight' => 'bold', 'left' => '20', 'top' => '10px' })
      end
    end
  end

  describe Hash do
    subject do
      {
        width: 10,
        'x' => '30',
        'font-weight' => 'bold',
        font_family: 'arial',
      }
    end

    describe '#render' do
      it 'returns a valid ruby hash string' do
        expect(subject.render)
          .to eq 'width: 10, x: 30, font_weight: "bold", font_family: "arial"'
      end
    end
  end
end
