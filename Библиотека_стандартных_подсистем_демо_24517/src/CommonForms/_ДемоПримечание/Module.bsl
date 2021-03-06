

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Параметры.Свойство("ПараметрыПодключаемыхКоманд") И Параметры.ПараметрыПодключаемыхКоманд.Свойство("Примечание") Тогда
		Примечание = Параметры.ПараметрыПодключаемыхКоманд.Примечание;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаОК(Команда)
	
	Если ВладелецФормы <> Неопределено Тогда
	
		ВладелецФормы.ПараметрыПодключаемыхКоманд.Вставить("Примечание", Примечание);
				
	КонецЕсли;
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

