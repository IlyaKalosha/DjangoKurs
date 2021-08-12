from django.db import connections
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.apps import apps
from .forms import NameForm
from .utils import pass_to_hash
import cx_Oracle
# Create your views here.
from manager.classes import Current_manager
from seller.classes import Current_seller



def login(request):
        if request.method == 'POST':
                form = NameForm(request.POST)
                if form.is_valid():
                        with connections['default'].cursor() as cursor:
                                res = cursor.callfunc(
                                        'dev_il.seller_pack.login',
                                        cx_Oracle.CURSOR,
                                        (form.cleaned_data['username'],
                                         pass_to_hash(form.cleaned_data['password']))
                                )
                                res_json = res.fetchall()
                                if res_json:
                                        Current_seller.id = res_json[0][0]
                                        Current_seller.name = res_json[0][1]
                                        Current_seller.surname = res_json[0][2]
                                        Current_seller.fathername = res_json[0][3]
                                        Current_seller.phone = res_json[0][4]
                                        Current_seller.login = res_json[0][5]
                                        Current_seller.pharmacy = res_json[0][7]
                                        return HttpResponseRedirect('/seller/home')
        else:
                form = NameForm()
        return render(request, 'myAuth/login_page.html', {'form': form})

def manager_login(request):
        if request.method == 'POST':
                form = NameForm(request.POST)
                if form.is_valid():
                        with connections['manager'].cursor() as cursor:
                                res = cursor.callfunc(
                                        'dev_il.manager_pack.login',
                                        cx_Oracle.CURSOR,
                                        (form.cleaned_data['username'],
                                         pass_to_hash(form.cleaned_data['password']))
                                )
                                res_json = res.fetchall()
                                if res_json:
                                        Current_manager.id = res_json[0][0]
                                        Current_manager.name = res_json[0][1]
                                        Current_manager.surname = res_json[0][2]
                                        Current_manager.fathername = res_json[0][3]
                                        Current_manager.phone = res_json[0][4]
                                        Current_manager.login = res_json[0][5]
                                        Current_manager.pharmacy = res_json[0][7]
                                        return HttpResponseRedirect('/manager/home')
        else:
                form = NameForm()

        return render(request, 'myAuth/manager_login_page.html', {'form': form})
