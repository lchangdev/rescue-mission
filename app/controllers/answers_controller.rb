class AnswersController < ApplicationController

  def create
    @answer = Answer.new(answer_params)
    # currently @answer question_id is null
    @answer.question_id = params[:question_id]
    # set @answer question_id to the params question_id
    if @answer.save
      redirect_to question_path(@answer.question), notice: "You have successfully posted your answer."
    else
      flash[:notice] = "Your description is not long enough"
      redirect_to question_path(@answer.question)
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.best_answer_count += 1
    @answer.save
    redirect_to(question_path(@answer.question))
  end

  private

  def answer_params
    params.require(:answer).permit(:description)
    binding.pry
  end

end
