# frozen_string_literal: true

class CustomLeadsController < ApplicationController
  def new
    @custom_lead = CustomLead.new
  end

  def create
    @custom_lead = CustomLead.new(custom_lead_params)

    if @custom_lead.save
      redirect_to new_custom_lead_path, notice: I18n.t('comum_lead.successfully_created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def custom_lead_params
    params.require(:custom_lead).permit(:first_name, :last_name, :email)
  end
end
