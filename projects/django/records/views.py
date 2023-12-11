from django.http import HttpResponse
from django.shortcuts import render, redirect
from .models import *


def index(request):
    if request.method != 'GET':
        return HttpResponse(status=405)

    view_params = {'genres': Genre.objects.all()}

    if len(request.GET) != 0:
        records = Record.objects

        if request.GET.get('name', ''):
            records = records.filter(name__contains=request.GET['name'])

        if request.GET.get('artist', ''):
            records = records.filter(artist__contains=request.GET['artist'])

        if request.GET.get('year', ''):
            records = records.filter(year__lte=request.GET['year'])

        if request.GET.get('genre', ''):
            records = records.filter(genre__exact=request.GET['genre'])

        view_params['records'] = records.all()

    return render(request, 'index.html', view_params)


def delete(request):
    if request.method != 'POST':
        return HttpResponse(status=405)

    print(f"Deleting record {request.POST['id']}...")
    return redirect('index')
