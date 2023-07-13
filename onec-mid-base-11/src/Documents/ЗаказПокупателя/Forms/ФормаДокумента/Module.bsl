
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	// КИВ 13.07.23 Програмное добавление полей на форму ==>    
	НТЛ_ДобавлениеПолейНаФорму();
	// КИВ 13.07.23 Програмное добавление полей на форму <==
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
    
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
		
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	// КИВ 13.07.23 Изменение расчета суммы с учетом скидки ==> 
	// Начало доработки 
	//Исходный код:
	//КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	//ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;  
	//
	//Новый код:
	Если ЗначениеЗаполнено(Объект.НТЛ_СогласованнаяСкидка) Тогда 
		ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество -
						     (ТекущиеДанные.Цена * ТекущиеДанные.Количество * Объект.НТЛ_СогласованнаяСкидка / 100); 
	Иначе 
		КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
		ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество;
	КонецЕсли;
	
	РассчитатьСуммуДокумента();
	//КонецДоработки
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

// КИВ 13.07.23 Добавление элементов на форму
&НаСервере 
Процедура НТЛ_ДобавлениеПолейНаФорму()      
	
	ПолеКонтактноеЛицо = Элементы.Добавить("КонтактноеЛицо", Тип("ПолеФормы"), Элементы.ГруппаШапкаПраво);
    ПолеКонтактноеЛицо.Вид = ВидПоляФормы.ПолеВвода;
	ПолеКонтактноеЛицо.ПутьКДанным = "Объект.НТЛ_КонтактноеЛицо";  
	
	ГруппаСкидки = Элементы.Добавить("ГруппаСкидки", Тип("ГруппаФормы"), ЭтотОбъект);
	ГруппаСкидки.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаСкидки.Заголовок = "Скидка";
	
	ПолеСогласованнаяСкидка = Элементы.Добавить("СогласованнаяСкидка", Тип("ПолеФормы"), ГруппаСкидки);
	ПолеСогласованнаяСкидка.Вид = ВидПоляФормы.ПолеВвода;
	ПолеСогласованнаяСкидка.ПутьКДанным = "Объект.НТЛ_СогласованнаяСкидка";
	
	КомандаРассчитатьСкидку = Команды.Добавить("РассчитатьСкидку");
	КомандаРассчитатьСкидку.Заголовок = "Рассчитать скидку";
	КомандаРассчитатьСкидку.Действие = "НТЛ_РассчитатьСкидку";
	
	КнопкаФормы = Элементы.Добавить("РассчитатьСкидку", 
									 Тип("КнопкаФормы"),             
									 ГруппаСкидки);                      		
	КнопкаФормы.ИмяКоманды = "РассчитатьСкидку";   
	
	Элементы.Переместить(ГруппаСкидки, ЭтотОбъект, Элементы.Страницы); 
	
КонецПроцедуры 

// КИВ 16.05.23 Процедура пересчета суммы по табличным частям с учетом скидки
&НаКлиенте
Процедура НТЛ_РассчитатьСкидку() 
	
	Для Каждого Строка Из Объект.Товары Цикл   		
		РассчитатьСуммуСтроки(Строка);	
	КонецЦикла;
	
КонецПроцедуры

// КИВ 13.07.23 Добавление элементов на форму

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
