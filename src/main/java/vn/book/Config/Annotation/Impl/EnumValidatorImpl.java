package vn.book.Config.Annotation.Impl;

import java.util.ArrayList;
import java.util.List;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import vn.book.Config.Annotation.EnumValidator;

public class EnumValidatorImpl implements ConstraintValidator<EnumValidator, String>{
	List<String> valueList = null;

	@Override
	public boolean isValid(String value, ConstraintValidatorContext context) {
		return valueList.contains(value.toUpperCase());
	}

	@Override
	public void initialize(EnumValidator constraintAnnotation) {
		valueList = new ArrayList<String>();
        Class<? extends Enum<?>> enumClass = constraintAnnotation.enumClazz();

        @SuppressWarnings("rawtypes")
        Enum[] enumValArr = enumClass.getEnumConstants();

        for (@SuppressWarnings("rawtypes") Enum enumVal : enumValArr) {
            valueList.add(enumVal.toString().toUpperCase());
        }
	}
	
	
}
