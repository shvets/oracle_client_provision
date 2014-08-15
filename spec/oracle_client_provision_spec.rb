require File.expand_path('spec_helper', File.dirname(__FILE__))

require 'oracle_client_provision'

describe OracleClientProvision do
  subject { OracleClientProvision.new self.class, ".oracle_client_provision.json"}

  describe "#install" do
    it "calls install method" do
      expect(subject).to receive(:run).exactly(2).times

      subject.install
    end
  end

end
