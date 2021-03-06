# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id                  :bigint           not null, primary key
#  external_id         :integer
#  name                :string
#  description         :string
#  logo                :string
#  start_date          :integer
#  start_date_category :integer
#  url                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Company, type: :model do
  subject do
    described_class.new(external_id: 1, name: 'Ethu Inc',
                        description: 'A newly rock start in the gaming world', logo: 'Fancey')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  # 19560: God Of War
  # 19565: Spiderman
  # it  "can fetch API data " do
  #   result = subject.fetchAPIData(19560,'Publisher')
  #   puts result
  #   expect(result).not_to be_nil
  # end

  # it "can save API data " do
  #   before_count = Company.count

  #   subject.saveAPIData(19560,'Publisher')

  #   expect(Company.count).not_to eq(before_count)
  # end

  it 'can find company name' do
    game_id = 13
    publisher = subject.findCompany(game_id, 'Publisher')
    # developer = subject.findCompany(game_id,'Developer')

    expect(publisher).not_to be_nil
    # expect(developer).not_to be_nil
    expect(publisher.name).not_to be_nil
    expect(developer.name).not_to be_nil
  end

  # it "can update involved_company" do
  #   result = subject.updateInvolvedCompanies(1,'Publisher')
  #   expect(result).to_be valid
  # end
end
