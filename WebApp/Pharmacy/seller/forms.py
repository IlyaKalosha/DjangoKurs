from django import forms


class PillSearchName(forms.Form):
    pillname = forms.CharField(max_length=50, label="",
                             widget=forms.TextInput(
                                    attrs={'class': 'form-control my-1', 'placeholder': 'Наименование'}))
    isSearchGlobal = forms.BooleanField(label="Поиск по всем аптекам", required=None, widget=forms.CheckboxInput(
                                    attrs={'class': 'm-3', 'placeholder': 'Поиск по всем аптекам'}
                                    ))

class PillSearchCategory(forms.Form):
    category = forms.CharField(max_length=15, label="",
                               widget=forms.TextInput(
                                   attrs={'class': 'form-control my-1', 'placeholder': 'Категория'}))
    isSearchGlobal = forms.BooleanField(label="Поиск по всем аптекам", required=None, widget=forms.CheckboxInput(
                                        attrs={'class': 'm-3', 'placeholder': 'Поиск по всем аптекам'}
                                        ))
class AddPillToBasket(forms.Form):
    ID = forms.IntegerField(label="",
                            widget=forms.NumberInput(
                                attrs={'class': 'form-control my-1', 'placeholder': 'ID для добавления'}))
    Count = forms.IntegerField(label="",
                            widget=forms.NumberInput(
                                attrs={'class': 'form-control my-1', 'placeholder': 'Количество'}))

class RecipeSearchId(forms.Form):
    ID = forms.IntegerField(label="",
                            widget=forms.NumberInput(
                                attrs={'class': 'form-control my-1', 'placeholder': 'ID для поиска'}))

