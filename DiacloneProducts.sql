select 
	*
from 
	tblProductsNew
INNER JOIN
	tblProductCategories
ON
	tblProductsNew.ID = tblProductCategories.ProductID
INNER JOIN
	tblCategories
ON
	tblProductCategories.CategoryID = tblCategories.CatID