from django.shortcuts import render, redirect
from django.contrib.auth import login
from django.contrib import messages
from .forms import CustomUserCreationForm

def register(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            messages.success(request, 'Регистрация успешна!')
            return redirect('home')
        else:
            messages.error(request, 'Ошибка регистрации. Пожалуйста, исправьте ошибки.')
    else:
        form = CustomUserCreationForm()
    return render(request, 'accounts/register.html', {'form': form})