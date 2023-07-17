describe RubySource do
  subject { described_class.new code, filename }

  let(:code) { "puts 'hello'" }
  let(:filename) { nil }

  it 'has a Victor::SVG instance' do
    expect(subject.svg).to be_a Victor::SVG
  end

  it 'includes Victor::DSL methods' do
    expect(subject).to respond_to :setup
  end

  describe '#evaluate' do
    it 'evaluates the ruby code' do
      expect { subject.evaluate }.to output("hello\n").to_stdout
    end

    context 'when the file contains a relative require' do
      let(:filename) { 'spec/fixtures/ruby_source/with_require.rb' }
      let(:code) { File.read filename }

      it 'evaluates the ruby code with the correct context' do
        expect { subject.evaluate }.to output("hello from required\n").to_stdout
      end
    end
  end

  describe '#template' do
    it 'sets the template on the svg instance' do
      expect(subject.svg).to receive(:template=).with(:minimal)
      subject.template 'minimal'
    end

    context 'when the template is a filename' do
      let(:template_file) { 'spec/fixtures/ruby_source/template.svg' }

      it 'sets the template on the svg instance' do
        expect(subject.svg).to receive(:template=).with(template_file)
        subject.template template_file
      end

      context 'when the file is not found' do
        let(:template_file) { 'no-such-template.svg' }

        it 'raises a friendly error' do
          # Different Ruby versions show exception slightly differently
          # Hence the diff
          expect { subject.template template_file }
            .to raise_approval('ruby_source/invalid-template')
            .diff(4)
        end
      end
    end
  end
end
