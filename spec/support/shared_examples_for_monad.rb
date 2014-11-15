RSpec.shared_examples "a monad" do

  let(:test_value) { "test value" }
  let(:f) { ->(value) { described_class.unit "f#{value}" } }
  let(:g) { ->(value) { described_class.unit "g#{value}" } }

  subject { described_class.unit test_value }


  it "should obey the 1st monad law" do
    expect(subject.bind &f).to eq f.call(test_value)
  end


  it "should obey the 2nd monad law" do
    expect(subject.bind { |value| described_class.unit value }).to eq subject
  end


  it "should obey the 3rd monad law" do
    chained_result = subject.bind { |value| f.call value }.bind { |value| g.call value }
    nested_result = subject.bind { |v1| f.call(v1).bind { |v2| g.call v2 } }

    expect(nested_result).to eq chained_result
  end

end
