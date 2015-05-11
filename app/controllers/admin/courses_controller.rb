class Admin::CoursesController < Admin::ApplicationController

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    course_info = course_params
    # create a course with temporarily generated permalink
    course = Course.create(course_info.merge(:permalink => SecureRandom.hex))

    redirect_to admin_courses_path
  end

  def update
    course.update_attributes(course_params)
    redirect_to admin_courses_path(course)
  end

  def edit
    course
  end

  def clone_and_update
    course = Course.find_by_permalink(params[:id])
    CloneAndUpdateJob.perform_later(course)
    redirect_to admin_courses_path
  end

  def generate_discourse_topics
    course
    begin
      @course.lessons.each do |lesson|
        lesson.create_qa_topic
      end
      head :ok
    rescue => e
      render json:{ 'msg': e.to_s }, status: :bad_request
    end
  end

  private

  def course_params
     params.require(:course).permit(:name, :repo_url, :current_version)
  end

  def course
    @course ||= Course.find_by(permalink: params[:id])
  end

end
