from django import forms

class NamesForm(forms.Form):
    names_json = forms.CharField(widget=forms.HiddenInput)