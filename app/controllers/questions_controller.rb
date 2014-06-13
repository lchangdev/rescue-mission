class QuestionsController < ApplicationController

  def index
    @questions = Question.all.order(updated_at: :desc)
  end

  # must initiate a new question class before form is shown
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    # if company is saved redirect to company's page
    if @question.save

      # flash[:notice] = "You have successfully posted your question."

      redirect_to @question, notice: "You have successfully posted your question."
    elsif question_params["title"].length < 40
      flash.now[:notice] = "Your title is not long enough"
      render :new
      # render is not a completely new page and keeps the params from the previous
    elsif question_params["description"].length < 150
      flash.now[:notice] = "Your description is not long enough"
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  private
  # makes it only for internal use

  def question_params
    # :company is the key to access the values
    # :company do not want anyone to teach anything except for company and white list what the user can touch
    params.require(:question).permit(:title, :description)
  end
end
