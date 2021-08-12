from django.db import connections
from django.shortcuts import render
from . import utils
from . import forms
from manager.classes import Current_manager
import cx_Oracle
# Create your views here.

def manager(request):
    name = Current_manager.name
    return render(request, 'manager/manager.html',{'name':name})

def pharmacy(request):
    if request.method == 'POST':
        form = forms.UpdatePharmacy(request.POST)
        if form.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.alter_pharmacy',
                    int,
                    (int(Current_manager.pharmacy),form.cleaned_data['city'],form.cleaned_data['district'],
                     form.cleaned_data['street'],form.cleaned_data['index'],form.cleaned_data['phone'])
                )
                if res:
                    form = forms.UpdatePharmacy()
            table = utils.get_pharmacy()
            return render(request, 'manager/manage_pharmacy.html', {'table': table,'form' : form})

    else:
        form = forms.UpdatePharmacy()
        table = utils.get_pharmacy()
    return render(request, 'manager/manage_pharmacy.html', {'table' : table, 'form' : form})

def pill(request):
    if request.method == 'POST' and 'pillsearchname' in request.POST:
        pillSearchNameForm = forms.PillSearchName(request.POST)
        if pillSearchNameForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.get_pill_name',
                    cx_Oracle.CURSOR,
                    (pillSearchNameForm.cleaned_data['pillname'],)
                )
                table = res.fetchall()
                if table:
                    pillSearchNameForm = forms.PillSearchName()
                addPillForm = forms.AddPill()
                updatePillForm = forms.UpdatePill()
                deletePillForm = forms.DeletePill()
                pillSearchDateForm = forms.PillSearchDate()
                pillSearchCostForm = forms.PillSearchCost()
                pillSearchCategoryForm = forms.PillSearchCategory()
                return render(request, 'manager/manage_pill.html',
                              {
                                  'table':table,
                                  'addPillForm': addPillForm,
                                  'updatePillForm': updatePillForm,
                                  'deletePillForm': deletePillForm,
                                  'pillSearchDateForm': pillSearchDateForm,
                                  'pillSearchNameForm': pillSearchNameForm,
                                  'pillSearchCostForm': pillSearchCostForm,
                                  'pillSearchCategoryForm': pillSearchCategoryForm
                              })
    elif request.method == 'POST' and 'pillsearchcategory' in request.POST:
        pillSearchCategoryForm = forms.PillSearchCategory(request.POST)
        if pillSearchCategoryForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.get_pill_category',
                    cx_Oracle.CURSOR,
                    (pillSearchCategoryForm.cleaned_data['category'],)
                )
                table = res.fetchall()
                if table:
                    pillSearchCategoryForm = forms.PillSearchCategory()
                addPillForm = forms.AddPill()
                updatePillForm = forms.UpdatePill()
                deletePillForm = forms.DeletePill()
                pillSearchNameForm = forms.PillSearchName()
                pillSearchDateForm = forms.PillSearchDate()
                pillSearchCostForm = forms.PillSearchCost()
                return render(request, 'manager/manage_pill.html',
                              {
                                  'table': table,
                                  'addPillForm': addPillForm,
                                  'updatePillForm': updatePillForm,
                                  'deletePillForm': deletePillForm,
                                  'pillSearchDateForm': pillSearchDateForm,
                                  'pillSearchNameForm': pillSearchNameForm,
                                  'pillSearchCostForm': pillSearchCostForm,
                                  'pillSearchCategoryForm': pillSearchCategoryForm
                              })
    elif request.method == 'POST' and 'pillsearchcost' in request.POST:
        pillSearchCostForm = forms.PillSearchCost(request.POST)
        if pillSearchCostForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.get_pill_cost',
                    cx_Oracle.CURSOR,
                    (pillSearchCostForm.cleaned_data['startcost'],
                     pillSearchCostForm.cleaned_data['endcost'])
                )
                table = res.fetchall()
                if table:
                    pillSearchCostForm = forms.PillSearchCost()
                pillSearchCategoryForm = forms.PillSearchCategory()
                addPillForm = forms.AddPill()
                updatePillForm = forms.UpdatePill()
                deletePillForm = forms.DeletePill()
                pillSearchNameForm = forms.PillSearchName()
                pillSearchDateForm = forms.PillSearchDate()
                return render(request, 'manager/manage_pill.html',
                              {
                                  'table': table,
                                  'addPillForm': addPillForm,
                                  'updatePillForm': updatePillForm,
                                  'deletePillForm': deletePillForm,
                                  'pillSearchDateForm': pillSearchDateForm,
                                  'pillSearchNameForm': pillSearchNameForm,
                                  'pillSearchCostForm': pillSearchCostForm,
                                  'pillSearchCategoryForm': pillSearchCategoryForm
                              })
    elif request.method == 'POST' and 'pillsearchDate' in request.POST:
        pillSearchDateForm = forms.PillSearchDate(request.POST)
        if pillSearchDateForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.get_pill_date',
                    cx_Oracle.CURSOR,
                    (pillSearchDateForm.cleaned_data['expiredate'],)
                )
                table = res.fetchall()
                if table:
                    pillSearchDateForm = forms.PillSearchDate()
                addPillForm = forms.AddPill()
                updatePillForm = forms.UpdatePill()
                deletePillForm = forms.DeletePill()
                pillSearchNameForm = forms.PillSearchName()
                pillSearchCostForm = forms.PillSearchCost()
                pillSearchCategoryForm = forms.PillSearchCategory()
                return render(request, 'manager/manage_pill.html',
                              {
                                  'table': table,
                                  'addPillForm': addPillForm,
                                  'updatePillForm': updatePillForm,
                                  'deletePillForm': deletePillForm,
                                  'pillSearchDateForm': pillSearchDateForm,
                                  'pillSearchNameForm': pillSearchNameForm,
                                  'pillSearchCostForm': pillSearchCostForm,
                                  'pillSearchCategoryForm': pillSearchCategoryForm
                              })
    elif request.method == 'POST' and 'updatepill' in request.POST:
        updatePillForm = forms.UpdatePill(request.POST)
        if updatePillForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.alter_pill',
                    int,
                    (updatePillForm.cleaned_data['ID'],
                     updatePillForm.cleaned_data['name'],
                     updatePillForm.cleaned_data['cost'],
                     updatePillForm.cleaned_data['regdate'],
                     updatePillForm.cleaned_data['enddate'],
                     updatePillForm.cleaned_data['category'],
                     updatePillForm.cleaned_data['country'],
                     updatePillForm.cleaned_data['barcode'],
                     updatePillForm.cleaned_data['recipe_id'],
                     updatePillForm.cleaned_data['info']
                     )
                )
                if res:
                    updatePillForm = forms.UpdatePill()
                addPillForm = forms.AddPill()
                deletePillForm = forms.DeletePill()
                pillSearchDateForm = forms.PillSearchDate()
                pillSearchNameForm = forms.PillSearchName()
                pillSearchCostForm = forms.PillSearchCost()
                pillSearchCategoryForm = forms.PillSearchCategory()
                return render(request, 'manager/manage_pill.html',
                              {
                                  'addPillForm': addPillForm,
                                  'updatePillForm': updatePillForm,
                                  'deletePillForm': deletePillForm,
                                  'pillSearchDateForm': pillSearchDateForm,
                                  'pillSearchNameForm': pillSearchNameForm,
                                  'pillSearchCostForm': pillSearchCostForm,
                                  'pillSearchCategoryForm': pillSearchCategoryForm
                              })
    elif request.method == 'POST' and 'addpill' in request.POST:
        addPillForm = forms.AddPill(request.POST)
        if addPillForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.create_pill',
                    int,
                    (addPillForm.cleaned_data['name'],
                     addPillForm.cleaned_data['cost'],
                     addPillForm.cleaned_data['regdate'],
                     addPillForm.cleaned_data['enddate'],
                     addPillForm.cleaned_data['category'],
                     addPillForm.cleaned_data['country'],
                     addPillForm.cleaned_data['barcode'],
                     addPillForm.cleaned_data['recipe_id'],
                     addPillForm.cleaned_data['info']))
                if res:
                    addPillForm = forms.AddPill()
                deletePillForm = forms.DeletePill()
                pillSearchDateForm = forms.PillSearchDate()
                updatePillForm = forms.UpdatePill()
                pillSearchNameForm = forms.PillSearchName()
                pillSearchCostForm = forms.PillSearchCost()
                pillSearchCategoryForm = forms.PillSearchCategory()
                return render(request, 'manager/manage_pill.html',
                              {
                                  'addPillForm': addPillForm,
                                  'updatePillForm': updatePillForm,
                                  'deletePillForm': deletePillForm,
                                  'pillSearchDateForm': pillSearchDateForm,
                                  'pillSearchNameForm': pillSearchNameForm,
                                  'pillSearchCostForm': pillSearchCostForm,
                                  'pillSearchCategoryForm': pillSearchCategoryForm
                              })
    elif request.method == 'POST' and 'deletepill' in request.POST:
        deletePillForm = forms.DeletePill(request.POST)
        if deletePillForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.delete_pill',
                    int,
                    (deletePillForm.cleaned_data['ID'],)
                )
                if res:
                    deletePillForm = forms.DeletePill()
                pillSearchDateForm = forms.PillSearchDate()
                addPillForm = forms.AddPill()
                updatePillForm = forms.UpdatePill()
                pillSearchNameForm = forms.PillSearchName()
                pillSearchCostForm = forms.PillSearchCost()
                pillSearchCategoryForm = forms.PillSearchCategory()
                return render(request, 'manager/manage_pill.html',
                              {
                                  'addPillForm': addPillForm,
                                  'updatePillForm': updatePillForm,
                                  'deletePillForm': deletePillForm,
                                  'pillSearchDateForm': pillSearchDateForm,
                                  'pillSearchNameForm': pillSearchNameForm,
                                  'pillSearchCostForm': pillSearchCostForm,
                                  'pillSearchCategoryForm': pillSearchCategoryForm
                              })
    else:
        addPillForm = forms.AddPill()
        updatePillForm = forms.UpdatePill()
        deletePillForm = forms.DeletePill()
        pillSearchDateForm = forms.PillSearchDate()
        pillSearchNameForm = forms.PillSearchName()
        pillSearchCostForm = forms.PillSearchCost()
        pillSearchCategoryForm = forms.PillSearchCategory()
        return render(request, 'manager/manage_pill.html',
                      {
                       'addPillForm': addPillForm,
                       'updatePillForm': updatePillForm,
                       'deletePillForm': deletePillForm,
                       'pillSearchDateForm': pillSearchDateForm,
                       'pillSearchNameForm': pillSearchNameForm,
                       'pillSearchCostForm': pillSearchCostForm,
                       'pillSearchCategoryForm': pillSearchCategoryForm
                       })

def recipe(request):
    if request.method == 'POST' and 'searchDoctor' in request.POST:
        recipeSearchDoctorForm = forms.RecipeSearchDoctor(request.POST)
        if recipeSearchDoctorForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.get_recipe_doctor',
                    cx_Oracle.CURSOR,
                    (recipeSearchDoctorForm.cleaned_data['doctor'],)
                )
                table = res.fetchall()
                if table:
                    recipeSearchDoctorForm = forms.RecipeSearchDoctor()
            recipeSearchDateForm = forms.RecipeSearchDate()
            addRecipe = forms.AddRecipe()
            deleteRecipe = forms.DeleteRecipe()
            updateRecipe = forms.UpdateRecipe()
            return render(request, 'manager/manage_recipe.html',
                          {'table': table,
                           'recipeSearchDoctorForm':recipeSearchDoctorForm,
                           'recipeSearchDateForm':recipeSearchDateForm,
                           'deleteRecipe': deleteRecipe,
                           'addRecipe': addRecipe,
                           'updateRecipe': updateRecipe
                         })
    elif request.method == 'POST' and 'searchDate' in request.POST:
        recipeSearchDateForm = forms.RecipeSearchDate(request.POST)
        if recipeSearchDateForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.get_recipe_date',
                    cx_Oracle.CURSOR,
                    (recipeSearchDateForm.cleaned_data['expiredate'],)
                )
                table = res.fetchall()
                if table:
                    recipeSearchDateForm = forms.RecipeSearchDate()
            recipeSearchDoctorForm = forms.RecipeSearchDoctor()
            addRecipe = forms.AddRecipe()
            deleteRecipe = forms.DeleteRecipe()
            updateRecipe = forms.UpdateRecipe()
            return render(request, 'manager/manage_recipe.html',
                          {'table': table,
                           'recipeSearchDoctorForm': recipeSearchDoctorForm,
                           'recipeSearchDateForm': recipeSearchDateForm,
                           'deleteRecipe': deleteRecipe,
                           'addRecipe': addRecipe,
                           'updateRecipe': updateRecipe
                           })
    elif request.method == 'POST' and 'addrecipe' in request.POST:
        addRecipe = forms.AddRecipe(request.POST)
        if addRecipe.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.create_recipe',
                    int,
                    (addRecipe.cleaned_data['doctor'],
                     addRecipe.cleaned_data['signature'],
                     addRecipe.cleaned_data['expiredate'])
                )
                if res:
                    addRecipe = forms.AddRecipe()
            recipeSearchDateForm = forms.RecipeSearchDate()
            recipeSearchDoctorForm = forms.RecipeSearchDoctor()
            deleteRecipe = forms.DeleteRecipe()
            updateRecipe = forms.UpdateRecipe()
            return render(request, 'manager/manage_recipe.html',
                          {
                            'recipeSearchDoctorForm': recipeSearchDoctorForm,
                           'recipeSearchDateForm': recipeSearchDateForm,
                           'deleteRecipe': deleteRecipe,
                           'addRecipe': addRecipe,
                           'updateRecipe': updateRecipe
                           })
    elif request.method == 'POST' and 'updaterecipe' in request.POST:
        updateRecipe = forms.UpdateRecipe(request.POST)
        if updateRecipe.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.alter_recipe',
                    int,
                    (updateRecipe.cleaned_data['ID'],
                     updateRecipe.cleaned_data['doctor'],
                     updateRecipe.cleaned_data['signature'],
                     updateRecipe.cleaned_data['expiredate'])
                )
                if res:
                    updateRecipe = forms.UpdateRecipe()
            recipeSearchDateForm = forms.RecipeSearchDate()
            recipeSearchDoctorForm = forms.RecipeSearchDoctor()
            addRecipe = forms.AddRecipe()
            deleteRecipe = forms.DeleteRecipe()
            return render(request, 'manager/manage_recipe.html',
                          {
                           'recipeSearchDoctorForm': recipeSearchDoctorForm,
                           'recipeSearchDateForm': recipeSearchDateForm,
                           'deleteRecipe': deleteRecipe,
                           'addRecipe': addRecipe,
                           'updateRecipe': updateRecipe
                           })
    elif request.method == 'POST' and 'deleterecipe' in request.POST:
        deleteRecipe = forms.DeleteRecipe(request.POST)
        if deleteRecipe.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.delete_recipe',
                    int,
                    (deleteRecipe.cleaned_data['ID'],)
                )
                if res:
                    deleteRecipe = forms.DeleteRecipe()
            recipeSearchDateForm = forms.RecipeSearchDate()
            recipeSearchDoctorForm = forms.RecipeSearchDoctor()
            addRecipe = forms.AddRecipe()
            updateRecipe = forms.UpdateRecipe()
            return render(request, 'manager/manage_recipe.html',
                          {
                           'recipeSearchDoctorForm': recipeSearchDoctorForm,
                           'recipeSearchDateForm': recipeSearchDateForm,
                           'deleteRecipe': deleteRecipe,
                           'addRecipe': addRecipe,
                           'updateRecipe': updateRecipe
                           })
    else:
        addRecipe = forms.AddRecipe()
        deleteRecipe = forms.DeleteRecipe()
        updateRecipe = forms.UpdateRecipe()
        recipeSearchDateForm = forms.RecipeSearchDate()
        recipeSearchDoctorForm = forms.RecipeSearchDoctor()
        return render(request, 'manager/manage_recipe.html',
                    {'recipeSearchDoctorForm':recipeSearchDoctorForm,
                     'recipeSearchDateForm':recipeSearchDateForm,
                     'deleteRecipe': deleteRecipe,
                     'addRecipe': addRecipe,
                     'updateRecipe': updateRecipe
                     })

def seller(request):
    if request.method == 'POST' and 'addseller' in request.POST:
        addSellerForm = forms.AddSeller(request.POST)
        if addSellerForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.create_seller',
                    int,
                    (addSellerForm.cleaned_data['name'],addSellerForm.cleaned_data['surname'],
                     addSellerForm.cleaned_data['fathername'], addSellerForm.cleaned_data['phone'],
                     addSellerForm.cleaned_data['login'], utils.pass_to_hash(addSellerForm.cleaned_data['password']),
                     Current_manager.id)
                )
                if res:
                    addSellerForm = forms.AddSeller()
            deleteSellerForm = forms.DeleteSeller()
            updateSellerForm = forms.UpdateSeller()
            table = utils.get_celler()
            return render(request, 'manager/manage_seller.html',
                          {'table': table,
                           'addSellerForm': addSellerForm,
                           'deleteSellerForm': deleteSellerForm,
                           'updateSellerForm': updateSellerForm
                           })
    elif request.method == 'POST' and 'deleteseller' in request.POST:
        deleteSellerForm = forms.DeleteSeller(request.POST)
        if deleteSellerForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.delete_seller',
                    int,
                    (deleteSellerForm.cleaned_data['ID'],)
                )
                if res:
                    deleteSellerForm = forms.DeleteSeller()
            addSellerForm = forms.AddSeller()
            updateSellerForm = forms.UpdateSeller()
            table = utils.get_celler()
            return render(request, 'manager/manage_seller.html',
                          {'table': table,
                           'addSellerForm': addSellerForm,
                           'deleteSellerForm': deleteSellerForm,
                           'updateSellerForm': updateSellerForm
                           })
    elif request.method == 'POST' and 'updateseller' in request.POST:
        updateSellerForm = forms.UpdateSeller(request.POST)
        if updateSellerForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.alter_seller',
                    int,
                    (int(updateSellerForm.cleaned_data['ID']), updateSellerForm.cleaned_data['name'],
                     updateSellerForm.cleaned_data['surname'], updateSellerForm.cleaned_data['fathername'],
                     updateSellerForm.cleaned_data['phone'], updateSellerForm.cleaned_data['login'],
                     utils.pass_to_hash(updateSellerForm.cleaned_data['password']))
                )
                if res:
                    updateSellerForm = forms.UpdateSeller()
            addSellerForm = forms.AddSeller()
            deleteSellerForm = forms.DeleteSeller()
            table = utils.get_celler()
            return render(request, 'manager/manage_seller.html',
                          {'table': table,
                           'addSellerForm': addSellerForm,
                           'deleteSellerForm': deleteSellerForm,
                           'updateSellerForm': updateSellerForm
                           })
    else:
        addSellerForm = forms.AddSeller()
        deleteSellerForm = forms.DeleteSeller()
        updateSellerForm = forms.UpdateSeller()
        table = utils.get_celler()
        print(table)
    return render(request, 'manager/manage_seller.html',
                  {'table': table,
                   'addSellerForm': addSellerForm,
                   'deleteSellerForm': deleteSellerForm,
                   'updateSellerForm': updateSellerForm
                   })

def storage(request):
    if request.method == 'POST' and 'storagesearchid' in request.POST:
        storageSearchIdForm = forms.StorageSearchId(request.POST)
        if storageSearchIdForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.get_storage',
                    cx_Oracle.CURSOR,
                    (storageSearchIdForm.cleaned_data['ID'],
                     Current_manager.pharmacy)
                )
                table = res.fetchall()
                if table:
                    storageSearchIdForm = forms.StorageSearchId()
            addStorageForm = forms.AddStorage()
            updateStorageForm = forms.UpdateStorage()
            deleteStorageForm = forms.DeleteStorage()
            return render(request, 'manager/manage_storage.html',
                          {
                              'table': table,
                              'storageSearchIdForm': storageSearchIdForm,
                              'addStorageForm': addStorageForm,
                              'updateStorageForm': updateStorageForm,
                              'deleteStorageForm': deleteStorageForm
                          })
    elif request.method == 'POST' and 'addstorage' in request.POST:
        addStorageForm = forms.AddStorage(request.POST)
        if addStorageForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.create_storage',
                    int,
                    (addStorageForm.cleaned_data['pillId'],
                    addStorageForm.cleaned_data['count'],
                    Current_manager.pharmacy)
                )
                if res:
                    addStorageForm = forms.AddStorage()
            storageSearchIdForm = forms.StorageSearchId()
            updateStorageForm = forms.UpdateStorage()
            deleteStorageForm = forms.DeleteStorage()
            return render(request, 'manager/manage_storage.html',
                          {
                              'storageSearchIdForm': storageSearchIdForm,
                              'addStorageForm': addStorageForm,
                              'updateStorageForm': updateStorageForm,
                              'deleteStorageForm': deleteStorageForm
                          })
    elif request.method == 'POST' and 'updatestorage' in request.POST:
        updateStorageForm = forms.UpdateStorage(request.POST)
        if updateStorageForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.alter_storage',
                    int,
                    (
                     updateStorageForm.cleaned_data['ID'],
                     updateStorageForm.cleaned_data['pillId'],
                     updateStorageForm.cleaned_data['count'],
                     Current_manager.pharmacy)
                    )
                if res:
                    updateStorageForm = forms.UpdateStorage()
            addStorageForm = forms.AddStorage()
            storageSearchIdForm = forms.StorageSearchId()
            deleteStorageForm = forms.DeleteStorage()
            return render(request, 'manager/manage_storage.html',
                          {
                              'storageSearchIdForm': storageSearchIdForm,
                              'addStorageForm': addStorageForm,
                              'updateStorageForm': updateStorageForm,
                              'deleteStorageForm': deleteStorageForm
                          })
    elif request.method == 'POST' and 'deletestorage' in request.POST:
        deleteStorageForm = forms.DeleteStorage(request.POST)
        if deleteStorageForm.is_valid():
            with connections['manager'].cursor() as cursor:
                res = cursor.callfunc(
                    'dev_il.manager_pack.delete_storage',
                    int,
                    (deleteStorageForm.cleaned_data['ID'],))
                if res:
                    deleteStorageForm = forms.DeleteStorage()
            updateStorageForm = forms.UpdateStorage()
            addStorageForm = forms.AddStorage()
            storageSearchIdForm = forms.StorageSearchId()
            return render(request, 'manager/manage_storage.html',
                          {
                              'storageSearchIdForm': storageSearchIdForm,
                              'addStorageForm': addStorageForm,
                              'updateStorageForm': updateStorageForm,
                              'deleteStorageForm': deleteStorageForm
                          })
    else:
        storageSearchIdForm = forms.StorageSearchId()
        addStorageForm = forms.AddStorage()
        updateStorageForm = forms.UpdateStorage()
        deleteStorageForm = forms.DeleteStorage()
    return render(request, 'manager/manage_storage.html',
                  {
                      'storageSearchIdForm': storageSearchIdForm,
                      'addStorageForm': addStorageForm,
                      'updateStorageForm': updateStorageForm,
                      'deleteStorageForm': deleteStorageForm
                  })