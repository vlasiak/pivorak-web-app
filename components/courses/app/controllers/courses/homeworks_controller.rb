module Courses
  class HomeworksController < BaseController
    helper_method :homework, :lectures

    def new
      @homework = ::Courses::Homework.new
      render_form
    end

    def create
      @homework = Homework::Create.call(homework_params, current_student.id)
      react_to homework.save
    end

    private

    def default_redirect
      redirect_to courses_season_path(current_season)
    end

    def homework
      @homework ||= ::Courses::Homework.find(params[:id])
    end

    def lectures
      @lectures ||=  Homework::AvailableLectures.call(current_season, current_student)
    end

    def homework_params
      params.require(:homework).permit(:git_url, :showcase_url, :lecture_id)
    end
  end
end
