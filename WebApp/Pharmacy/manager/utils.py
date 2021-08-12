import hashlib
import cx_Oracle
from .classes import Current_manager
from django.db import connections


def pass_to_hash(password):
    return hashlib.sha512(str.encode(password)).hexdigest().upper()

def get_pharmacy():
    with connections['manager'].cursor() as cursor:
        res = cursor.callfunc(
            'dev_il.manager_pack.get_pharmacy',
            cx_Oracle.CURSOR,
            (Current_manager.pharmacy,)
        )
    return res

def get_celler():
    with connections['manager'].cursor() as cursor:
        res = cursor.callfunc(
            'dev_il.manager_pack.get_celler',
            cx_Oracle.CURSOR,
            (Current_manager.id,)
        )
    return res.fetchall()