from django import forms

class NameForm(forms.Form):
    username = forms.EmailField(label='username',max_length=50)
    password = forms.CharField(label='password', widget=forms.PasswordInput,max_length=50)