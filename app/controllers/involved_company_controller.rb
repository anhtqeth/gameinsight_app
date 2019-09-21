class InvolvedCompanyController < ApplicationController
  
  def update
    @involve_company = InvolvedCompany.find(params[:id])
    
    #developer = ? publisher = ? company_id: ? game_id: ?
    
    if @involve_company.update_attributes(involve_company_params)
      flash.now[:success] = "Game Company Updated!"
      redirect_back(fallback_location: root_path)
    else
      
    end
  end
  
  private
    def involve_company
      params.require(:screenshot).permit(:developer,:publisher,:company_id,:game_id)
    end
  
  
end
