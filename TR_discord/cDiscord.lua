function remoteDsc(message, user)
	if message and user then -- dziura
		triggerServerEvent("remoteDC", resourceRoot, message, user);
	end;
end;