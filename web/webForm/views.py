import json

from django.shortcuts import render
from django.shortcuts import render, redirect
from .models import FormData
from .forms import NamesForm

def add_entries(request):
    if request.method == 'POST':
        names_json = request.POST.get('names_json')
        if names_json:
            try:
                data = json.loads(names_json)
                FormData.objects.create(data=data)
                return redirect('webForm:show_entries')
            except json.JSONDecodeError:
                pass
    return render(request, 'add_entries.html')

def show_entries(request):
    entries = FormData.objects.all()
    return render(request, 'show_entries.html', {'entries': entries})
