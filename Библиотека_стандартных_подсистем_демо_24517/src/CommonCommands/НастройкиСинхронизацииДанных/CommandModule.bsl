
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыРаботыКлиента = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиентаПриЗапуске();
	ИмяОткрываемойФормы = ?(ПараметрыРаботыКлиента.РазделениеВключено,
		"ОбщаяФорма.СинхронизацияДанныхВМоделиСервиса",
		"ОбщаяФорма.СинхронизацияДанных");
	
	ОткрытьФорму(ИмяОткрываемойФормы);
	
КонецПроцедуры

#КонецОбласти
