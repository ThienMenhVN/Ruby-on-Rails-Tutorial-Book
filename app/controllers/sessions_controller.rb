class SessionsController < ApplicationController
  def new
    #cookie thông thường
    cookies[:demo_normal] = "normal"

    #giá trị của cookie sẽ được mã hóa
    #cookie này được mã hóa với key là `secrets.secret_key_base`
    cookies.signed[:demo_signed] = "signed"

    #giá trị được mã hóa tương tự như coolie.signed
    #cookie này được mã hóa với key là `secrets.secret_key_base`
    cookies.encrypted[:demo_encrypted] = "encrypted"

    #khi dùng http only thì coolie hông thể đọc được bằng javascript, và cookie sẽ hết hạn sau thời gian quy định 
    cookies[:demo_httponly] = {value: "http only", exprires: Time.current + 1.hour , httponly: true}

    #hết hạn sau thời gian dài khoản 20 năm
    cookies.permanent[:demo_permanent] = "permanent"

  end

  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase
    if user&.authenticate params.dig(:session, :password)
    # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to user
    else
    # Create an error message.
      flash.now[:danger] = t "invalid_email_password_combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
