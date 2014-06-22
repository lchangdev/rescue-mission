class QuestionsController < ApplicationController

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end


  def set_current_user(user)
    session[:user_id] = user.id
  end

  def authenticate!
    unless signed_in?
      flash[:notice] = 'You need to sign in if you want to do that!'
      redirect_to questions_path
    end
  end

  def index
    @questions = Question.all.order(updated_at: :desc)
    binding.pry
  end

  def new
    authenticate!
    @question = Question.new
  end

  def create

    @question = Question.new(question_params)

    if @question.save
      flash[:notice] = "You have successfully posted your question."
      redirect_to @question
    end

    # if question_params["title"].length < 40
    #   flash[:notice] = "Your title is not long enough"
    #   render :new
    # elsif question_params["description"].length < 150
    #   flash[:notice] = "Your description is not long enough"
    #   render :new
    # else @question.save
    #   redirect_to @question, notice: "You have successfully posted your question."
    # end
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = Answer.all.where("question_id = ?", params[:id]).order(best_answer_count: :desc)
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = "Success"

      redirect_to question_path
    else
      flash[:notice] = "Did not save try again"
      # if description or title is too short will display this message
      # not very information
      render :new
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = "You have deleted this question."

    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :description)
  end
end
