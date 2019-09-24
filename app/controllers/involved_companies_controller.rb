class InvolvedCompaniesController < ApplicationController
  def update
    @involve_company = InvolvedCompany.find(params[:id])
    
    #developer = ? publisher = ? company_id: ? game_id: ?
    
    if @involve_company.update_attributes(involved_company_params)
      puts 'Updating Involve Company ...'
      puts involved_company_params
      flash.now[:success] = "Game Company Updated!"
      redirect_back(fallback_location: root_path)
    else
      puts 'Error Updating Involve Company'
      puts @involve_company.errors.messages
    end
  end
  
  private
  #TODO - Need all other attribute?
    def involved_company_params
      params.require(:involved_company).permit(:publisher,:company_id,:game_id)
    end
  
end
