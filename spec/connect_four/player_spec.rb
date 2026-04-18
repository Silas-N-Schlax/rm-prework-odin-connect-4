require_relative "../../lib/connect_four/player"

describe Player do
  describe "#username" do
    context "when user inputs name" do
      before do
        allow(subject).to receive(:gets).and_return("bob")
      end
      it "returns value" do
        expect(subject).to receive(:print).with("\e[0;33;49mPlease enter your name! ->\e[0m")
        expect(subject.username).to eq("bob")
      end
    end
    context "when user inputs name longer then 12 chars" do
      before do
        allow(subject).to receive(:gets).and_return("Salazar the Destroyer")
      end
      it "returns the first 12 chars only" do
        expect(subject).to receive(:print).with("\e[0;33;49mPlease enter your name! ->\e[0m")
        expect(subject.username).to eq("Salazar the D")
      end
    end
  end
end
