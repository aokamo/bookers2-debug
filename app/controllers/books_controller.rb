class BooksController < ApplicationController

before_action :authenticate_user!

  def show
    @book = Book.new
    @user_book = Book.find(params[:id])
    @user = @user_book.user
    @book_comment = BookComment.new
    @book_comments = BookComment.all
  end

  def index
    @book = Book.new
    @books = Book.page(params[:page]).reverse_order
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    if
      @book.save
      redirect_to book_path(@book), notice:'You have created book successfully.'
    else
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to book_path(@user_book)
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
