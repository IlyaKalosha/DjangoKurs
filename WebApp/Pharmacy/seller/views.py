from django.db import connections
from django.http import HttpResponseRedirect
from django.shortcuts import render
from seller.classes import Current_seller, Order
from . import forms
import cx_Oracle
# Create your views here.

def seller(request):
    name = Current_seller.name
    return render(request, 'seller/seller.html', {'name': name})


def pill(request):
    if request.method == 'POST' and 'pillsearchname' in request.POST:
        pillSearchNameForm = forms.PillSearchName(request.POST)
        if pillSearchNameForm.is_valid():
            if pillSearchNameForm.cleaned_data['isSearchGlobal']:
                with connections['default'].cursor() as cursor:
                    res = cursor.callfunc(
                        'dev_il.seller_pack.check_item_global',
                        cx_Oracle.CURSOR,
                        (pillSearchNameForm.cleaned_data['pillname'],)
                    )
            else:
                with connections['default'].cursor() as cursor:
                    res = cursor.callfunc(
                        'dev_il.seller_pack.check_item_local',
                        cx_Oracle.CURSOR,
                        (pillSearchNameForm.cleaned_data['pillname'],
                         Current_seller.pharmacy)
                    )
            table = res.fetchall()
            if table:
                pillSearchNameForm = forms.PillSearchName()
            pillSearchCategoryForm = forms.PillSearchCategory()
            return render(request, 'seller/pillInfo.html',
                          {
                              'table': table,
                              'pillSearchNameForm': pillSearchNameForm,
                              'pillSearchCategoryForm': pillSearchCategoryForm
                          })
    elif request.method == 'POST' and 'pillsearchcategory' in request.POST:
        pillSearchCategoryForm = forms.PillSearchCategory(request.POST)
        if pillSearchCategoryForm.is_valid():
            if pillSearchCategoryForm.cleaned_data['isSearchGlobal']:
                with connections['default'].cursor() as cursor:
                    res = cursor.callfunc(
                        'dev_il.seller_pack.check_category_global',
                        cx_Oracle.CURSOR,
                        (pillSearchCategoryForm.cleaned_data['category'],)
                    )
                table = res.fetchall()
                if table:
                    pillSearchCategoryForm = forms.PillSearchCategory()
                pillSearchNameForm = forms.PillSearchName()
                return render(request, 'seller/pillInfo.html',
                              {
                                  'table': table,
                                  'pillSearchNameForm': pillSearchNameForm,
                                  'pillSearchCategoryForm': pillSearchCategoryForm
                              })
            else:
                with connections['default'].cursor() as cursor:
                    res = cursor.callfunc(
                        'dev_il.seller_pack.check_category_local',
                        cx_Oracle.CURSOR,
                        (pillSearchCategoryForm.cleaned_data['category'],
                         Current_seller.pharmacy)
                    )
                table = res.fetchall()
                if table:
                    pillSearchCategoryForm = forms.PillSearchCategory()
                pillSearchNameForm = forms.PillSearchName()
                return render(request, 'seller/pillInfo.html',
                              {
                                  'table': table,
                                  'pillSearchNameForm': pillSearchNameForm,
                                  'pillSearchCategoryForm': pillSearchCategoryForm
                              })
    else:
        pillSearchCategoryForm = forms.PillSearchCategory()
        pillSearchNameForm = forms.PillSearchName()
        return render(request, 'seller/pillInfo.html',
                      {
                          'pillSearchNameForm': pillSearchNameForm,
                          'pillSearchCategoryForm': pillSearchCategoryForm
                      })


def recipe(request):
    if request.method == 'POST' and 'searchID' in request.POST:
        recipeSearchIdForm = forms.RecipeSearchId(request.POST)
        if recipeSearchIdForm.is_valid():
            with connections['default'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.seller_pack.get_recipe',
                    cx_Oracle.CURSOR,
                    (recipeSearchIdForm.cleaned_data['ID'],)
                )
            table = res.fetchall()
            if table:
                recipeSearchIdForm = forms.RecipeSearchId()
            return render(request, 'seller/recipeInfo.html',
                          {
                              'table': table,
                              'recipeSearchIdForm': recipeSearchIdForm
                          })
    else:
        recipeSearchIdForm = forms.RecipeSearchId()
        return render(request, 'seller/recipeInfo.html',
                      {
                          'recipeSearchIdForm': recipeSearchIdForm
                      })


def order(request):
    if request.method == 'POST' and 'createorder' in request.POST:
        with connections['default'].cursor() as cursor:
            res = cursor.callfunc(
                'dev_il.seller_pack.create_order',
                int,
                (Current_seller.id,
                 Current_seller.pharmacy)
            )
            if res:
                orderId = res;
                Order.id = orderId
            else:
                orderId = ''
        addPillToBasketForm = forms.AddPillToBasket()
        return render(request, 'seller/order.html',
               {'orderId': orderId,
                'addPillToBasketForm':addPillToBasketForm
                })
    elif request.method == 'POST' and 'addtobasket' in request.POST:
        addPillToBasketForm = forms.AddPillToBasket(request.POST)
        if addPillToBasketForm.is_valid():
            with connections['default'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.seller_pack.add_to_basket',
                    int,
                    (Order.id,
                     addPillToBasketForm.cleaned_data['ID'],
                     addPillToBasketForm.cleaned_data['Count'],
                     Current_seller.pharmacy)
                )
                if res:
                    basket = cursor.callfunc(
                    'dev_il.seller_pack.create_check_getorder',
                    cx_Oracle.CURSOR,
                    (Order.id,))
                    table = basket.fetchall()
                    if table:
                        Order.basket = table
                        addPillToBasketForm = forms.AddPillToBasket()
                        return render(request, 'seller/order.html',
                                      {
                                          'orderId':Order.id,
                                          'table':table,
                                          'addPillToBasketForm': addPillToBasketForm
                                       })
                else:
                    return render(request, 'seller/order.html',
                                  {
                                      'orderId': Order.id,
                                      'table': Order.basket,
                                      'addPillToBasketForm': addPillToBasketForm
                                  })
    elif request.method == 'POST' and 'generatecheck' in request.POST:
        with connections['default'].cursor() as cursor:
            check_info = cursor.callfunc(
                'dev_il.seller_pack.create_check_getinfo',
                cx_Oracle.CURSOR,
                (Order.id,))
            check_basket = cursor.callfunc(
                'dev_il.seller_pack.create_check_getorder',
                cx_Oracle.CURSOR,
                (Order.id,))
            check_info_table = check_info.fetchall()
            check_basket_table = check_basket.fetchall()
            if check_info_table!=None and check_basket_table!=None:
                return render(request, 'seller/check.html',
                              {
                                  'check_info_table': check_info_table,
                                  'check_basket_table': check_basket_table
                              })

    else:
        addPillToBasketForm = forms.AddPillToBasket()
        return render(request, 'seller/order.html',{'addPillToBasketForm':addPillToBasketForm})
