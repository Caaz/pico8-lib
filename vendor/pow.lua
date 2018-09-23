function pow(x,a)
	if (a==0) return 1
	if (a<0) x,a=1/x,-a
	local ret,a0,xn=1,flr(a),x
	a-=a0
	while a0>=1 do
	if (a0%2>=1) ret*=xn
	xn,a0=xn*xn,shr(a0,1)
	end
	while a>0 do
	while a<1 do x,a=sqrt(x),a+a end
	ret,a=ret*x,a-1
	end
	return ret
end
