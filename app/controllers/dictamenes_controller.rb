class DictamenesController < ApplicationController
  def index
  end

  def new
      @dictamen = Dictamen.new
      @proyecto = Proyecto.find(params[:idpy])
  end

  def create
  end
end
