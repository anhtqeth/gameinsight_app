require 'rails_helper'

RSpec.describe Company, type: :model do
  subject {
    described_class.new(external_id: 1,name: "Ethu Inc", 
    description: "A newly rock start in the gaming world", logo: "Fancey")
  }
  
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid 
  end
  
  #19560: God Of War
  #19565: Spiderman
  it  "can fetch API data " do 
    result = subject.fetchAPIData(19560,'Publisher')
    puts result
    expect(result).not_to be_nil
  end
  
  it "can save API data " do
    before_count = Company.count
    
    subject.saveAPIData(19560,'Publisher')
    
    expect(Company.count).not_to eq(before_count)
  end
  
  # it "can update involved_company" do
  #   result = subject.updateInvolvedCompanies(1,'Publisher')
  #   expect(result).to_be valid
  # end
  
    
end
